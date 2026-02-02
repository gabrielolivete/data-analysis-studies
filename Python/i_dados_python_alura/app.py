import streamlit as st
import pandas as pd
import plotly.express as px

# --- Page Setup ---
# Defining the page title, icon and layout to occupy the entire width.
st.set_page_config(
    page_title="Salary Dashboard in Data Area",
    page_icon="📊",
    layout="wide",
)

# --- Data upload ---
df = pd.read_csv("https://raw.githubusercontent.com/vqrca/dashboard_salarios_dados/refs/heads/main/dados-imersao-final.csv")

# --- Sidebar (Filters) ---
st.sidebar.header("🔍 Filters")

# Year filter
avaiable_years = sorted(df['ano'].unique())
selected_years = st.sidebar.multiselect("Year", avaiable_years, default = avaiable_years)

# Experience Level filter
avaiable_experiences = sorted(df['senioridade'].unique())
selected_experiences = st.sidebar.multiselect("Experience Level", avaiable_experiences, default=avaiable_experiences)

# Filter by contract type
avaiable_contracts = sorted(df['contrato'].unique())
selected_contracts = st.sidebar.multiselect("Contract Type", avaiable_contracts, default=avaiable_contracts)

# Size company filter
avaiable_size_company = sorted(df['tamanho_empresa'].unique())
selected_size_company = st.sidebar.multiselect("Size Company", avaiable_size_company, default=avaiable_size_company)

# --- DataFrame filtering ---
# The ain DataFrame is filtered based on the selections made in the sidebar filters.
df_filtered = df[
    (df['ano'].isin(selected_years)) &
    (df['senioridade'].isin(selected_experiences)) &
    (df['contrato'].isin(selected_contracts)) &
    (df['tamanho_empresa'].isin(selected_size_company))
]

# --- Main Content ---
st.title("🎲 Salary Analysis Dashboard in the Data Area")
st.markdown("Explore salary trends and insights in the data field with this interactive dashboard.")

# --- Key Metrics (KPIs) ---
st.subheader("General metrics (annual salary in USD)")

if not df_filtered.empty:
    salario_medio = df_filtered['usd'].mean()
    salario_maximo = df_filtered['usd'].max()
    total_registros = df_filtered.shape[0]
    cargo_mais_frequente = df_filtered["cargo"].mode()[0]
else:
    salario_medio, salario_maximo, total_registros, cargo_mais_frequente = 0, 0, 0, ""
col1, col2, col3, col4 = st.columns(4)
col1.metric("Average Salary", f"${salario_medio:,.0f}")
col2.metric("Maximum Salary", f"${salario_maximo:,.0f}")
col3.metric("Total Records", f"{total_registros:,}")
col4.metric("Most Frequent Position", cargo_mais_frequente)

st.markdown("---")

# --- Visual Analyses with Plotly ---
st.subheader("Charts")

col_graf1, col_graf2 = st.columns(2)

with col_graf1:
    if not df_filtered.empty:
        top_positions = df_filtered.groupby('cargo')['usd'].mean().nlargest(10).sort_values(ascending=True).reset_index()
        position_chart = px.bar(
            top_positions,
            x='usd',
            y='cargo',
            orientation='h',
            title="Top 10 positions by average salary",
            labels={'usd': 'Average annual salary (USD)', 'cargo': ''}
        )
        position_chart.update_layout(title_x=0.1, yaxis={'categoryorder':'total ascending'})
        st.plotly_chart(position_chart, use_container_width=True)
    else:
        st.warning("No data to display in the top positions chart.")

with col_graf2:
    if not df_filtered.empty:
        graph_hist = px.histogram(
            df_filtered,
            x='usd',
            nbins=30,
            title="Annual salary distribution",
            labels={'usd': 'Annual salary range (USD)', 'count': ''}
        )
        graph_hist.update_layout(title_x=0.1)
        st.plotly_chart(graph_hist, use_container_width=True)
    else:
        st.warning("No data to display in the salary distribution chart.")

col_graf3, col_graf4 = st.columns(2)

with col_graf3:
    if not df_filtered.empty:
        remote_count = df_filtered['remoto'].value_counts().reset_index()
        remote_count.columns = ['type_work', 'quantity']
        graph_remote = px.pie(
            remote_count,
            names='type_work',
            values='quantity',
            title='Proportion of work types',
            hole=0.5  
        )
        graph_remote.update_traces(textinfo='percent+label')
        graph_remote.update_layout(title_x=0.1)
        st.plotly_chart(graph_remote, use_container_width=True)
    else:
        st.warning("No data to display in the work types chart.")

with col_graf4:
    if not df_filtered.empty:
        df_ds = df_filtered[df_filtered['cargo'] == 'Data Scientist']
        country_average = df_ds.groupby('residencia_iso3')['usd'].mean().reset_index()
        graph_country = px.choropleth(country_average,
            locations='residencia_iso3',
            color='usd',
            color_continuous_scale='rdylgn',
            title='Average salary of Data Scientists by country',
            labels={'usd': 'Average salary (USD)', 'residencia_iso3': 'Country'})
        graph_country.update_layout(title_x=0.1)
        st.plotly_chart(graph_country, use_container_width=True)
    else:
        st.warning("No data to display in the country chart.") 
        
# --- Detailed Data Table ---
st.subheader("Detailed Data")
st.dataframe(df_filtered)