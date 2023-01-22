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
  rename( Año = 'Año',
          Botulismo = 'Casos - Botulismo',
         Fiebre_dengue = 'Casos - Fiebre del Dengue',
         Enfermedad_meningocitica = 'Casos - Enfermedad meningocócica',
         Fiebre_tifoidea_paratifoidea = 'Casos - Fiebres tifoidea y paratifoidea',
         Giardiasis = 'Casos - Giardiasis',
         HepatitisB = 'Casos - Hepatitis B',
         Hidatidosis = 'Casos - Hidatidosis',
         Gripe_aviar = 'Casos - Infección humana por virus de la gripe aviar',
         Nuevo_virus_gripe = 'Casos - Infección por nuevo virus de la gripe A(H1N1)',
         Leishmaniasis = 'Casos - Leishmaniasis',
         Hepatitis_víricas_otras = 'Casos - Otras hepatitis víricas',
         Paludismo = 'Casos - Paludismo') %>%
  select(1,2,3,9,15,23,24,28,30,32,35,37,45,46)


View(enf_declaracion_obligatoria)



#Por último, vamos a cargar la tabla 'fallecimientos-2017-2020-meses.csv', la cual se encuentra en la carpeta 'DATA' de nuestro repositorio:

fallecimientos_2017_2020 <- read_delim("INPUT/DATA/fallecimientos-2017-2020-meses.csv",
                                          delim = ";", escape_double= FALSE, trim_ws = TRUE)





# Formateamos la tabla para darla el aspecto que deseemos:

fallecimientos_2017_2020 <- fallecimientos_2017_2020 %>%
  select(1,2,4:8)



View(fallecimientos_2017_2020) 
