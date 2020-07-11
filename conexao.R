#install.packages("RPostgreSQL")
library(RPostgreSQL)

# Referência Completa
# https://cran.r-project.org/web/packages/RODBC/RODBC.pdf

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv,                     #Nome da instância criada anteriormente
                 dbname = "cliente",      #nome do database a ser acessado
                 host = "localhost",      #IP do server que hospeda o database
                 port = 5432,             #porta do server, geralmente 5432
                 user = "postgres",       #nome do usuário
                 password =  "SUA_SENHA") 

#################### Inserindo registros no banco
query = "insert into funcionarios (id_funcionario, nm_funcionario) values ($1,$2)"
dbSendQuery(con, query, c(3, "Paulo Antonio"))

#################### Alterando/excluindo registros com texto concatenado
res <- dbSendQuery(con, statement="update funcionarios set nm_funcionario='Maria' where id_funcionario=2")
#res <- dbSendQuery(con, statement="delete from funcionarios where id_funcionario=3")

#################### Alterando registros com texto concatenado
registros = dbGetQuery(con, "select * from funcionarios")
print(registros[1])               # Mostra todos registros da coluna 1
print(registros$id_funcionario)   # Mostra todos registros da coluna id_funcionario
print(registros[2])               # Mostra todos registros da coluna 2

#################### Fechando conexão e liberando driver
dbDisconnect(con)
dbUnloadDriver(drv)

