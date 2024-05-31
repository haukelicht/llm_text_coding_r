if (!"renv" %in% rownames(installed.packages()))
  install.packages("renv")

if (file.exists("renv.lock")) {
  renv::restore()
} else {
  renv::init()
  
  pkgs <- readLines(file.path("setup", "requirements.txt"))
  lapply(pkgs, renv::install)
  
  renv::snapshot()
} 
  
  


