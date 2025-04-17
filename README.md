# 🎵 Music Store Analysis 🎵

## 📌 Project Overview  
This project presents an in-depth SQL-based analysis of an online music store's data to derive meaningful business insights. The dataset consists of multiple tables, including customer details, invoices, tracks, and sales records. By leveraging MySQL, we explore revenue trends, popular music genres, top-selling artists, and customer purchasing patterns to help the store optimize its business strategies.

## 📂 Dataset Description  
The dataset contains the following key tables:
- **👨‍💼 Employees**: Contains details about the store's employees, including job titles.
- **🧑‍🤝‍🧑 Customers**: Stores customer information such as name, email, and country.
- **🧾 Invoices**: Includes transaction records, invoice totals, and customer purchase history.
- **🎵 Tracks**: Contains details of individual songs, including genre and length.
- **🎤 Artists**: Lists music artists and their associated albums.
- **🎶 Genres**: Stores information about different music genres.

## 🔍 Key Business Questions & SQL Queries  
We analyzed the dataset by answering the following business questions using SQL:

### 🟢 Basic Analysis  
1. **Who is the senior-most employee based on job title?** 👨‍💼  
2. **Which countries have the most invoices?** 🌍  
3. **What are the top 3 values of total invoice amounts?** 💰  
4. **Which city has the best customers?** 🏙️  
   - We identified the city generating the highest revenue, which can be used for promotional events.
5. **Who is the best customer?** 🏆  
   - We determined the customer who spent the most money on music purchases.

### 🟡 Intermediate Analysis  
1. **Find all Rock Music listeners.** 🎸  
   - We retrieved emails, names, and genre preferences of customers who listen to Rock music, sorted alphabetically by email.
2. **Top 10 Rock artists based on track count.** 🎤  
   - Identified the artists with the highest number of Rock tracks in the store’s catalog.
3. **Find all tracks longer than the average song length.** ⏳  
   - Extracted songs with durations greater than the dataset's average song length.

### 🔴 Advanced Analysis  
1. **How much has each customer spent on artists?** 💵  
   - Calculated the total amount spent by each customer on different artists.
2. **Most popular music genre by country.** 🌎🎶  
   - Determined the top-selling genre for each country based on purchases.
3. **Top customer by total spending in each country.** 🏅  
   - Found the highest-spending customer in each country and their total purchases.

## 💡 Insights Derived from the Analysis  
- **👨‍💼 Senior-most employee**: Identified the highest-ranked employee in the organization.
- **🌍 Most invoices by country**: Determined the top purchasing countries, allowing for targeted marketing.
- **🏙️ Top revenue-generating city**: Helps in planning promotional events and expanding business operations.
- **🏆 Best customer**: Found the highest-spending individual, useful for loyalty programs.
- **🎸 Top Rock music listeners**: Enables genre-specific marketing and artist promotions.
- **⏳ Longest tracks in the store**: Helps customers discover lengthy compositions and niche music interests.
- **💵 Spending trends on artists**: Useful for negotiating deals with artists based on customer spending behavior.
- **🌎🎶 Popular genre by country**: Helps in understanding regional music preferences for better curation.
- **🏅 Top customers by country**: Assists in country-specific marketing and VIP customer engagement.

## 🛠️ Technologies Used  
- **🗄️ Database**: MySQL
- **🖥️ Query Execution**: MySQL Workbench / SQL-based platforms
- **📊 Data Visualization (optional)**: Python (Pandas, Matplotlib, Seaborn)

## 🚀 How to Use This Project  
1. 📥 Clone the repository and access the SQL script.
2. 🏗️ Set up a MySQL database and import the dataset.
3. 🔎 Execute the provided SQL queries to extract insights.
4. 📊 Use visualization tools to represent findings effectively.

