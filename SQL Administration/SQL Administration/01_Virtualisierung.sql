/*
Ziel: Reduzierung von IO ==> weniger CPU und weniger RAM Verbrauch

RAM : genug
HDD :schnell
CPU

auch in der VM gleiche Bedingungen wie in einer physialischen Umgebung



NUMA

jeder Sockel hat seine eig Speicherslots..
jeder Zugriff auf den Speicher des anderen Sockel kostet mehr CPU Leistung




--Gesamter RAM:  16GB  Sockel  1  Kerne 4 log Prozessoren
--OS und HyperV: 4 GB -- >12 GB 

							log Proz        RAM
HV-DC					    1                 dyn. 512  2048   Start 1024
HV-SQL1                4                   fix: 5500
HV-SQL2                4                   fix: 4500



*/