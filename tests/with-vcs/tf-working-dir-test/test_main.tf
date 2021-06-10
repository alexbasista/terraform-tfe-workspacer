# resource "random_shuffle" "teststring" {
#     input = [
#         for stark in var.starks:
#         lower(stark)
#     ]
# }

resource "random_shuffle" "testlist" {
    input = [
        for i in var.testlist:
        upper(i)
    ]
}