resource "random_pet" "teststring" {
    length    = 2
    prefix    = var.teststring
    separator = "-"
}

resource "random_shuffle" "testlist" {
    input = [
        for i in var.testlist:
        upper(i)
    ]
}