sesiones<- list.files(path = "sesiones",pattern = ".rmd",recursive = TRUE)# a list with the names of the files to copy

# css<- list.files(path = "input/css",pattern = "custom")        # a list with the names of the files to copy

file.copy(file.path("sesiones",sesiones), "docs",overwrite = TRUE)# copy data proc and analysis files
# file.copy(file.path("input/css",css), "docs",overwrite = TRUE)       # copy css style files


rmarkdown::render_site("docs",quiet = F) # Render site



