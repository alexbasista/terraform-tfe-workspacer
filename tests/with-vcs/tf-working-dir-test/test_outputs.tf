output "teststring" {
    value = random_pet.teststring.id
}

output "secretstring" {
    value = random_pet.secstring.id
}

output "testlist" {
    value = random_shuffle.testlist.result
}