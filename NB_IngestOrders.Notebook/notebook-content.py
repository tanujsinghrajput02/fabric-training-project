# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "a5ad8e27-69d7-4cc7-b6c5-8739f73197d7",
# META       "default_lakehouse_name": "FabricTraining_LH",
# META       "default_lakehouse_workspace_id": "53dcddee-1a16-4051-9e0a-bed919d06fe7",
# META       "known_lakehouses": [
# META         {
# META           "id": "a5ad8e27-69d7-4cc7-b6c5-8739f73197d7"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Welcome to your new notebook
# Type here in the cell editor to add code!
df_orders = spark.read.format("csv") \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .load("Files/Raw/orders.csv")
 
display(df_orders)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import col,date_format
from pyspark.sql.types import DateType

df = spark.read.option("header",True).csv("Files/Raw/orders.csv")

df = df.withColumn("order_date",col("order_date").cast(DateType()))

df = df.withColumn(
    "year_month",
    date_format(col("order_date"),"yyyy-MM")
)

df.write.mode("overwrite").format("delta").saveAsTable("orders_bronze")

display(df)

df.printSchema()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df = spark.read.option("header",True).csv("Files/Raw/customers.csv")

df.write.mode("overwrite").format("delta").saveAsTable("customers")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

DESCRIBE DETAIL orders_bronze

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC DESCRIBE DETAIL orders_bronze

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC OPTIMIZE orders_bronze
# MAGIC ZORDER BY (order_date)

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC VACUUM orders_bronze RETAIN 168 HOURS

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC DESCRIBE HISTORY orders_bronze

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC ANALYZE TABLE orders_bronze
# MAGIC COMPUTE STATISTICS

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }
