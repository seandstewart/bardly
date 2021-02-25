var tables = document.querySelectorAll("article table")
tables.forEach(function (table) {
    new Tablesort(table, {descending: true})
})
