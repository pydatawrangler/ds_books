import polars as pl

flights = pl.read_csv('flights.csv', ignore_errors=True)
print(flights)

(
    flights
    .select("distance", "air_time", "dest")
    .with_columns(speed = pl.col("distance")/pl.col("air_time") * 60)
    .group_by(pl.col("dest")).agg(
        avgSpeed = pl.col("speed").mean()
    )
    .sort("avgSpeed", descending=True)
)
