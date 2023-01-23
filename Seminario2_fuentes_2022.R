library (readxl)
library (dplyr)
library (tidyverse)

#Cargamos la tabla "tasa-mortalidad-por-centros-salud.csv" dentro de la carpeta DATA que hemos creado en nuestro repositorio:

tasa_mort_centrosalud <- read_delim("INPUT/DATA/tasa-mortalidad-por-centros-de-salud.csv",
                                    delim = ";", escape_double= FALSE, trim_ws = TRUE)



# Damos el aspecto que queremos a la tabla


tasa_mort_centrosalud <- tasa_mort_centrosalud [168703:175618, ]


tasa_mort_centrosalud <- tasa_mort_centrosalud %>% 
  rename(Fecha = 'FECHA',
         Centro = 'CENTRO',
         Fallecidos = 'FALLECIDOS',
         Tasa_tanto_por_ciento = 'TASAx100',
         Zona_basica_salud = 'zbs_geo',
         Provincia = 'PROVINCIA',
         Municipio = 'MUNICIPIO') %>%
  select(1,5:7, 10, 11, 13) %>%
  filter (Fallecidos >0)

View (tasa_mort_centrosalud)


# Ahora vamos a cargar la tabla "enfermedades-de-declaracion-obligatoria-casos-y-tasas-por-provincia.csv" de la carpeta DATA que se encuentra en nuestro repositorio:

enf_declaracion_obligatoria <- read_delim("INPUT/DATA/enfermedades-de-declaracion-obligatoria-casos-y-tasas-por-provincia.csv",
                                    delim = ";", escape_double= FALSE, trim_ws = TRUE)


# Formateamos la tabla para darla el aspecto que queramos


enf_declaracion_obligatoria <- enf_declaracion_obligatoria %>%
  rename( Fecha = 'Año',
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
  select(1,2,3,9,15,23,24,28,30,32,35,37,45,46) %>%
  pivot_longer(cols=c(Botulismo, Fiebre_dengue, Enfermedad_meningocitica, Fiebre_tifoidea_paratifoidea, Giardiasis, HepatitisB, Hidatidosis, Gripe_aviar, Nuevo_virus_gripe, Leishmaniasis, Hepatitis_víricas_otras, Paludismo),
               names_to = "Enfermedades",
               values_to = "Contagios")


View(enf_declaracion_obligatoria)



#Por último, vamos a cargar la tabla 'fallecimientos-2017-2020-meses.csv', la cual se encuentra en la carpeta 'DATA' de nuestro repositorio:

fallecimientos_2017_2020 <- read_delim("INPUT/DATA/fallecimientos-2017-2020-meses.csv",
                                          delim = ";", escape_double= FALSE, trim_ws = TRUE)





# Formateamos la tabla para darla el aspecto que deseemos:



fallecimientos_2017_2020 <- fallecimientos_2017_2020 %>%
  select(1,2,4:8) %>%
  rename(Año = 'año',
         Mes = 'mes',
         Provincia = 'provincia',
         Pacientes_total = 'pacientes_total',
         Tasa_total_pacientes = "tasa_pacientes_total",
         Pacientes_residencias = 'pacientes_residencias',
         Tasa_residencia = 'tasa_pacientes_residencias'
         )
  



View(fallecimientos_2017_2020)





# Representamos cada una de las tablas de forma gráfica para hacernos una idea más realista de los datos que estas recogen.

tasa_mort_centrosalud %>% 
  ggplot(data = ., aes(x = Fecha, y = Fallecidos)) +
  geom_bar(stat = "identity", aes(fill= Provincia))+
  theme_bw() + 
  labs(
    x = "Fecha del fallecimiento",
    y = "Numero de personas fallecidas",
    title = "Tasa de mortalidad por cada centro de salud ",
    colour = "Provincia"
  )





# Para basarnos en una enfermedad concreta, vamos a basarnos en Giardiasis, ya que hemos visto que en nuestra comunidad autónoma presenta un gran número de casos.

enf_declaracion_obligatoria %>% 
  ggplot(data = ., aes(x = Enfermedades, y = Contagios)) +
  geom_bar(stat = "identity", aes(fill= Provincia))+
  theme_bw() + 
  labs(
    x = "Enfermedad que han contradio",
    y = "Numero de personas contagiadas",
    title = "Número de personas que se contagian de enfermedades de declaración obligatoria en Castilla y León",
    colour = "Provincia"
  )




fallecimientos_2017_2020 %>% 
  ggplot(data = ., aes(x = Año, y = Pacientes_residencias)) +
  geom_bar(stat = 'identity', aes(fill= Provincia))+
  theme_bw() + 
  labs(
    x = 'Año del fallecimiento',
    y = "Pacientes fallecidos en residencias",
    title = "Número de personas que han muerto en residencias por año",
    colour = "Provincia"
  )



# Vamos a ver los datos que tienen en común las tablas para poder relacionarlas

levels(factor(tasa_mort_centrosalud$Provincia))
levels(factor(enf_declaracion_obligatoria$Provincia))
levels(factor(fallecimientos_2017_2020$Provincia))


# Podremos relacionar a las personas fallecidas en función de la enfermedad que han contraido


enfermedad_fallecimientos <- 
  enf_declaracion_obligatoria %>%
  select (Provincia, Enfermedades, Contagios) %>%
  full_join(x = .,
            y = fallecimientos_2017_2020 %>%
              select (Provincia, Pacientes_total, Pacientes_residencias),
            by = c ("Provincia" ="Provincia"))

View (enfermedad_fallecimientos)


# Vamos a representar una gráfica que relacione los contagios con el número de fallecidos

enfermedad_fallecimientos %>%
  filter(Contagios >1) %>%
  ggplot (data = ., aes(x = Contagios, y = Pacientes_total)) +
  geom_point (aes(color = Provincia)) + 
  labs (
    x = "Número de contagios que se han producido de cada enfermedad",
    y = "Número total de pacientes fallecidos",
    title = "Número de pacientes fallecidos en función del contagio de enfermedades"
  )



# Ahora vamos a ver el número total de pacientes fallecidos en cada provincia en el mes de Febrero del año 2021, y como se distribuye esto en las zonas básicas de salud, pudiendo así saber que zonas son las que presentan un mayor nivel de mortalidad


tasamort_fallecimientos <- 
  tasa_mort_centrosalud %>%
  select (Provincia, Zona_basica_salud, Fallecidos) %>%
  full_join(x = .,
            y = fallecimientos_2017_2020 %>%
              select (Provincia, Año, Mes, Pacientes_total, Pacientes_residencias),
            by = c ("Provincia" ="Provincia"))


tasamort_fallecimientos <- tasamort_enfermedades %>%
  filter(Año == 2021) %>%
  filter (Mes == "Febrero")

View (tasamort_enfermedades)


tasamort_fallecimientos %>%
  ggplot (data = ., aes(x = Pacientes_total, y = Zona_basica_salud)) +
  geom_point (aes(color = Provincia)) + 
  labs (
    x = "Número de pacientes que han fallecido durante este mes en residencias",
    y = "Zonas básicas de salud en las que se han producido las muertes",
    title = "Número de pacientes fallecidos en función de la zona de salud a la que pertenecen"
  )
