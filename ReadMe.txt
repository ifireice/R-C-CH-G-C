docker network create environment

зайти в контейнер с кликхаусом
# clickhouse-client
> CREATE TABLE graphite ( 
  Path String,  
  Value Float64,  
  Time UInt32,  
  Date Date,  
  Timestamp UInt32
) ENGINE = GraphiteMergeTree('graphite_rollup')
PARTITION BY toYYYYMM(Date)
ORDER BY (Path, Time);

> CREATE TABLE graphite_tree (
  Date Date,
  Level UInt32,
  Path String,
  Version UInt32
) ENGINE = ReplacingMergeTree(Version)
PARTITION BY toYYYYMM(Date)
ORDER BY (Level, Path, Date);

> CREATE TABLE graphite_tagged (
  Date Date,
  Tag1 String,
  Path String,
  Tags Array(String),
  Version UInt32
) ENGINE = ReplacingMergeTree(Version)
PARTITION BY toYYYYMM(Date)
ORDER BY (Tag1, Path, Date);

> CREATE TABLE graphite_tag (
    Date Date,
    Level UInt32,
    Tag1 String, 
    Path String, 
    IsLeaf UInt8,
    Tags Array(String),
    Version UInt32
) ENGINE = ReplacingMergeTree(Date, (Tag1, Level, Path), 8192, Version);

Отправить метрику с хостовой машины
# echo "local.random.diceroll 4 `date +%s`" | nc localhost 2003

