# CityZenith - Urban Sustainability Analytics Dashboard

A full-stack application for analyzing urban green spaces, air quality, and property values with machine learning predictions.

## 🚀 Tech Stack

### Frontend
- **Next.js** (App Router) with TypeScript
- **Redux Toolkit** for state management
- **Chakra UI** for components
- **Leaflet** & **React-Leaflet** for maps
- **Recharts** for data visualization

### Backend
- **Node.js** with Express & TypeScript
- **MySQL** database
- **Flask** microservice for ML model

### Data & ML
- **Python** ETL pipelines
- **scikit-learn** Random Forest model
- **OpenStreetMap**, **OpenAQ**, **Zillow** data sources

## 📁 Project Structure
cityzenith/
├── client/ # Next.js frontend
├── server/ # Express.js backend
├── etl/ # Python ETL scripts
├── model/ # Jupyter notebook & model training
└── README.md


## 🛠️ Setup Instructions

### Prerequisites
- Node.js 18+
- Python 3.8+
- MySQL 8.0+

### Installation
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/cityzenith.git
   cd cityzenith
2. **Setup Backend**
    ```bash
    cd server
    npm install
    cp .env.example .env
    # Configure your MySQL database in .env
    npm run dev
3. **Setup Frontend**
    ```bash
    cd client
    npm install
    npm run dev
4. **Run ETL Pipeline**
    ```bash
    cd etl-pipeline
    pip install -r requirements.txt
    python main.py
5. **Train ML Model**
    ```bash
    cd ml-model
    jupyter notebook
    # Open and run sustainability_score_model.ipynb

### 📊 Features
- Interactive map visualization of sustainability metrics
- Analytical dashboards with charts and trends
- Machine learning predictions for neighborhood sustainability scores
- Brazilian city data integration

### 🗃️ Database Schema
See database/schema.sql for complete table definitions.

### 📝 API Documentation
#### GET /api/neighborhoods
Returns all neighborhoods with aggregated metrics.
#### POST /api/predict-sustainability
Predicts sustainability score for a neighborhood.