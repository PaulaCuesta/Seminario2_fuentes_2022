library (readxl)
library (dplyr)
library (tidyverse)

#Cargamos la tabla "tasa-mortalidad-por-centros-salud.csv" dentro de la carpeta DATA que hemos creado en nuestro repositorio:

tasa_mort_centrosalud <- read_delim("INPUT/DATA/tasa-mortalidad-por-centros-de-salud.csv",
                                    delim = ";", escape_double= FALSE, trim_ws = TRUE)



# Damos el aspecto que queremos a la tabla


tasa_mort_centrosalud <- tasa_mort_centrosalud [168703:175618, ]

View (tasa_mort_centrosalud)


tasa_mort_centrosalud <- tasa_mort_centrosalud %>% 
  rename(TASA_TANTO_POR_CIENTO = 'TASAx100',
         ZONA_BASICA_SALUD = 'zbs_geo') %>%
  select(1,5:7, 10, 11, 13)





# Ahora vamos a cargar la tabla "enfermedades-de-declaracion-obligatoria-casos-y-tasas-por-provincia.csv" de la carpeta DATA que se encuentra en nuestro repositorio:

enf_declaracion_obligatoria <- read_delim("INPUT/DATA/enfermedades-de-declaracion-obligatoria-casos-y-tasas-por-provincia.csv",
                                    delim = ";", escape_double= FALSE, trim_ws = TRUE)


# Formateamos la tabla para darla el aspecto que queramos


enf_declaracion_obligatoria <- enf_declaracion_obligatoria %>%
  select(1,2,9,15,17,23,24,26,28,30,32,35,37,45,46) %>%
  rename(Botulismo = 'Casos - Botulismo',
         )


View(enf_declaracion_obligatoria)
    