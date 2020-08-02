CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (
 datetime VARCHAR(30),
 status INTEGER,
 statusCount INTEGER);
CREATE OR REPLACE PUMP "STREAM_PUMP" AS
 INSERT INTO "DESTINATION_SQL_STREAM"
 SELECT
 STREAM TIMESTAMP_TO_CHAR('yyyy-MM-dd''T''HH:mm:ss.SSS',
LOCALTIMESTAMP) as datetime,
 "response" as status,
 COUNT(*) AS statusCount
 FROM "SOURCE_SQL_STREAM_001"
 GROUP BY
 "response",
 FLOOR(("SOURCE_SQL_STREAM_001".ROWTIME - TIMESTAMP '1970-01-
01 00:00:00') minute / 1 TO MINUTE);