
-- SELECT * 
-- FROM sys.databases

-- SELECT * FROM sys.dm_os_wait_stats

SELECT TOP 10 wait_type, wait_time_ms, max_wait_time_ms
FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms DESC









