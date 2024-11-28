import polars as pl
from datetime import datetime

delivDF = pl.read_csv('shipDF.csv', try_parse_dates=True)
delivDF

shipDF = (
    delivDF
    .with_columns(
        pl.col("plannedShipDate").str.to_datetime("%m/%d/%Y"),
        pl.col("actualShipDate").str.to_datetime("%m/%d/%Y")
    )
)
shipDF

shipDF["actualShipDate"][0] - shipDF["plannedShipDate"][0]

thisDay = datetime.now()

thisDay.month
thisDay.year
thisDay.weekday()

shipDateDF = (
    shipDF
    .select("shipID", "plannedShipDate", "actualShipDate")
    .unique()
    .sort("shipID")
    .with_columns(
        lateFlag = pl.col("actualShipDate") > pl.col("plannedShipDate")
    )
)
shipDateDF

(
    shipDateDF
    .group_by("lateFlag")
    .agg(countLate = pl.col("shipID").len())
    .with_columns(proportion = pl.col("countLate") / pl.col("countLate").sum())
)

# 7.3