

md_connect <- function(config_env = 'default') {
    
    config <- config::get(config = config_env)
    
    #conn <- DBI::dbConnect(duckdb::duckdb(), "Data/ccdm_dev.db")
    conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
    
    # Authenticate with MotherDuck Token 
    DBI::dbExecute(conn, "INSTALL motherduck")
    DBI::dbExecute(conn, "LOAD 'motherduck'")
    
    if (config$md_token != "") { 
        auth_query <- paste0("SET motherduck_token='", config$md_token, "';")
        dbExecute(conn, auth_query)
        }
    
    # Attach to MotherDuck 
    DBI::dbExecute(conn, "ATTACH 'md:'")
   
    # return the connection object
    conn 
    
}


   
#    dbDisconnect(conn, shutdown = TRUE)
    