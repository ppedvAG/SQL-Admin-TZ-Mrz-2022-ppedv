dbcc showcontig()

select * from sys.dm_db_index_physical_stats(db_id(), NULL, NULL,NULL, 'detailed')
where page_count > 50000 and avg_page_space_used_in_percent < '90'