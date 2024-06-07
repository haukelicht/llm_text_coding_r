# list installed packages
installed_pkgs <- rownames(installed.packages())

# install required version of {renv} (if needed)
renv_version <- "1.0.7"
if (!"renv" %in% installed_pkgs) {
  if (!"remotes" %in% installed_pkgs)
    install.packages("remotes")
  remotes::install_version("renv", version = renv_version)
} else if (packageVersion("renv") != renv_version) {
  remotes::install_version("renv", version = renv_version)
}

# init the {renv} environment
renv::init(bare = TRUE, restart = TRUE)

# install the required packages
lock_file <- "renv.lock"
if (file.exists(lock_file)) {
  renv::restore(lockfile = lock_file, prompt = FALSE)
} else {
  pkgs <- readLines(file.path("setup", "requirements.txt"))
  renv::install(pkgs)
  renv::snapshot(lockfile = lock_file)
}


