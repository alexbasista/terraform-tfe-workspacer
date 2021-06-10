resource "random_shuffle" "testlist" {
    input = [
        for i in var.testlist:
        upper(i)
    ]
}
#