# Style
g_l_color <- "#3498db"
g_l_color2 <- "#f39c12"
main_season <- "#1e8449"
lame_season <- "#f7dc6f"
g_l_linetype <- 1
g_p_size <- 1
t_hjust <- 0.5
g_vl_linetype <- 3

get_scales <- function() {
  return(
    list(
      "combined" = list(
        x_supplier = function(Data) {
          return(purrr::map_dbl(Data$Order, function(a)
            (a / 12) + 2006))
        },
        x_label = "Jahr",
        x_min = 12.5,
        x_max = 12 * 15,
        vline = 12,
        angle = 0,
        save_scale = "combined",
        labels = c(
          rep("", 6),"2006",rep("", 5),
          rep("", 6),"2007",rep("", 5),
          rep("", 6),"2008",rep("", 5),
          rep("", 6),"2009",rep("", 5),
          rep("", 6),"2010",rep("", 5),
          rep("", 6),"2011",rep("", 5),
          rep("", 6),"2012",rep("", 5),
          rep("", 6),"2013",rep("", 5),
          rep("", 6),"2014",rep("", 5),
          rep("", 6),"2015",rep("", 5),
          rep("", 6),"2016",rep("", 5),
          rep("", 6),"2017",rep("", 5),
          rep("", 6),"2018",rep("", 5),
          rep("", 6),"2019",rep("", 5),
          rep("", 6),"2020",rep("", 5)
        )
      ),
      "yearly" = list(
        x_supplier = function(Data) {
          return(Data$timeScale)
        },
        x_label = "Jahr",
        x_min = 2006,
        x_max = 2020,
        vline = -1,
        angle = 0,
        save_scale = "yearly",
        labels = c(
          "2006",
          "2007",
          "2008",
          "2009",
          "2010",
          "2011",
          "2012",
          "2013",
          "2014",
          "2015",
          "2016",
          "2017",
          "2018",
          "2019",
          "2020"
        )
      ),
      "monthly" = list(
        x_supplier = function(Data) {
          return(Data$timeScale)
        },
        x_label = "Monat",
        x_min = 1,
        x_max = 12,
        vline = -1,
        angle = 0,
        save_scale = "monthly",
        labels = c(
          "Januar",
          "Februar",
          "M\u00E4rz",
          "April",
          "Mai",
          "Juni",
          "Juli",
          "August",
          "September",
          "Oktober",
          "November",
          "Dezember"
        )
      )
    )
  )
}

shouldDataframeScale = function(dataRow){
  return (is.null(dataRow) == FALSE && 
            is.na(max(dataRow, na.rm = TRUE)) == FALSE &&
            max(dataRow, na.rm = TRUE) >= 1000)
}

get_ordinates <- function() {
  return(list(
    "weight" = function(Dataframe, is_Export, is_Combined) {
      if (is_Export) {
        rowName = "Ausfuhr..Gewicht"
        rowName2 = "Einfuhr..Gewicht"
      }
      else {
        rowName = "Einfuhr..Gewicht"
        rowName2 = "Ausfuhr..Gewicht"
      }
      
      if (shouldDataframeScale(Dataframe[[rowName]]) || (is_Combined == TRUE && shouldDataframeScale(Dataframe[[rowName2]]))) {
        divider = 1
      }
      else {
        divider = 1
      }
      
      list(
        y_supplier = function(Data) {
          return(purrr::map_dbl(Dataframe[[rowName]], function(a)
            a / divider))
        },
        y_label = "Masse in t",
        y_title = "menge in Tonnen",
        save_ordinate = "weight"
      )
    },
    "euro" = function(Dataframe, is_Export, is_Combined) {
      if (is_Export) {
        rowName = "Ausfuhr..Wert"
        rowName2 = "Einfuhr..Wert"
      }
      else {
        rowName = "Einfuhr..Wert"
        rowName2 = "Ausfuhr..Wert"
      }
      
      if (shouldDataframeScale(Dataframe[[rowName]]) || (is_Combined == TRUE && shouldDataframeScale(Dataframe[[rowName2]]))) {
        divider = 1000
        y_label = "Volumen in Mio. \u20AC"
        y_title = "volumen in Euro"
      }
      else {
        divider = 1
        y_label = "Volumen in Tsd. \u20AC"
        y_title = "volumen in Euro"
      }
      list(
        y_supplier = function(Data) {
          return(purrr::map_dbl(Dataframe[[rowName]], function(a)
            a / divider))
        },
        y_label = y_label,
        y_title = y_title,
        save_ordinate = "Euro"
      )
    },
    "euro_per_weight" = function(Dataframe, is_Export, is_Combined) {
      if (is_Export) {
        rowName = "Ausfuhr..Wert.Gewicht"
        rowName2 = "Einfuhr..Wert.Gewicht"
      }
      else {
        rowName = "Einfuhr..Wert.Gewicht"
        rowName2 = "Ausfuhr..Wert.Gewicht"
      }
      
      if (shouldDataframeScale(Dataframe[[rowName]]) || (is_Combined == TRUE && shouldDataframeScale(Dataframe[[rowName2]]))) {
        divider = 1
      }
      else {
        divider = 1
      }
      list(
        y_supplier = function(Data) {
          return(purrr::map_dbl(Dataframe[[rowName]], function(a)
            a / divider))
        },
        y_label = "Wert in \u20AC/t",
        y_title = "wert in Euro pro Tonnen",
        save_ordinate = "Euro_per_weight"
      )
    }
  ))
}

getColumns <- function() {
  columnEntry <- function(row, name) {
    return(list("row" = row, "name" = name))
  }
  
  return(
    list(
      columnEntry("Ausfuhr..Gewicht", "Ausfuhr..Gewicht"),
      columnEntry("Ausfuhr..Wert", "Ausfuhr..Wert"),
      columnEntry("Ausfuhr..Wert.Gewicht", "Ausfuhr..Wert.Gewicht"),
      columnEntry("Einfuhr..Gewicht", "Einfuhr..Gewicht"),
      columnEntry("Einfuhr..Wert", "Einfuhr..Wert"),
      columnEntry("Einfuhr..Wert.Gewicht", "Einfuhr..Wert.Gewicht")
    )
  )
}
