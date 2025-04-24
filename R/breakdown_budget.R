#' Break down the budget
#'
#' @param data A data set
#' @param group_var A grouping variable
#' @import dplyr
#'
#' @return A total amount of budget expenditure by grouping variable
#' @export
breakdown_budget <- function(data, group_var){
  data |>
    group_by(
      across(
        all_of(group_var)
      )
    ) |>
    summarise(
      total_amount = sum(`Actual Amount ($)`),
      .groups = "drop"
    )
}

#' Visualize the budget breakdown
#'
#' @param data A data set
#' @param group_var A grouping variable
#' @import ggplot2 dplyr
#'
#' @return A ggplot
#' @export
visualize_breakdown <- function(data, group_var){
  data |>
    breakdown_budget(group_var) |>
    ggplot(
      aes(
        y = reorder(.data[[group_var]], total_amount),
        x = total_amount
      )
    ) +
    geom_col() +
    geom_text(
      aes(
        label = round(total_amount),
        hjust = -0.2
      )
    )
}
