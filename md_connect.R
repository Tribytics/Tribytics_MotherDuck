

md_connect <- function(config_env = 'default') {
    
    config <- config::get(config = config_env)
    #token <- Sys.getenv("MD_TOKEN")
    token <- config$md_token
    
    conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
    
    # Authenticate with MotherDuck Token 
    DBI::dbExecute(conn, "INSTALL motherduck")
    DBI::dbExecute(conn, "LOAD motherduck")
    
    auth_query <- paste0("SET motherduck_token='", token, "';")
    dbExecute(conn, auth_query)
    
    # Attach to MotherDuck 
    DBI::dbExecute(conn, "ATTACH 'md:'")
   
    # return the connection object
    conn 
    
}


   
#    dbDisconnect(conn, shutdown = TRUE)
    