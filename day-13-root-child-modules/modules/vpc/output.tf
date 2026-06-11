output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_1_id" {
  value = "${aws_subnet.main.id}"
}

output "subnet_2_ids" {
  value = "${aws_subnet.name.id}" #aws_subnet.name.id
}