if (!"renv" %in% rownames(installed.packages()))
  install.packages("renv")

lock_file <- "renv.lock"
if (file.exists(lock_file)) {
  renv::init(bare = TRUE, restart = FALSE)
  renv::restore(lockfile = lock_file, prompt = FALSE)
} else {
  renv::init(bare = TRUE, restart = FALSE)
  
  pkgs <- readLines(file.path("setup", "requirements.txt"))
  renv::install(pkgs)
  
  renv::snapshot()
} 


