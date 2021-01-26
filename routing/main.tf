provider "aws" {
  alias = "intersite"
}

provider "aws" {
  alias = "environment"
}

resource "aws_route" "public_route_table_route" {
  provider = aws.environment
  count = length(var.routable_cidr_blocks)

  route_table_id            = var.env_public_rt
  destination_cidr_block    = var.routable_cidr_blocks[count.index]
  transit_gateway_id        = var.tgw_id
}

resource "aws_route" "private_route_table_route" {
  provider = aws.environment
  count = length(var.routable_cidr_blocks)

  route_table_id            = var.env_private_rt
  destination_cidr_block    = var.routable_cidr_blocks[count.index]
  transit_gateway_id        = var.tgw_id
}

resource "aws_route" "intersite_public_route_table_route" {
  provider = aws.intersite

  route_table_id            = var.intersite_public_rt
  destination_cidr_block    = var.env_vpc_cidr
  transit_gateway_id        = var.tgw_id
}

resource "aws_route" "intersite_private_route_table_route" {
  provider = aws.intersite

  route_table_id            = var.intersite_private_rt
  destination_cidr_block    = var.env_vpc_cidr
  transit_gateway_id        = var.tgw_id
}

//resource "aws_security_group_rule" "allow_mgmt_env_in" {
//  provider = aws.environment
//  security_group_id = data.terraform_remote_state.env_vpc.outputs.management_sg
//  type = "ingress"
//  from_port = 0
//  to_port = 0
//  protocol = "-1"
//  cidr_blocks = [data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr]
//}
//
//resource "aws_security_group_rule" "allow_mgmt_env_out" {
//  provider = aws.environment
//  security_group_id = data.terraform_remote_state.env_vpc.outputs.management_sg
//  type = "egress"
//  from_port = 0
//  to_port = 0
//  protocol = "-1"
//  cidr_blocks = [data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr]
//}
//
//resource "aws_network_acl_rule" "intersite-to-env-pub" {
//  provider = aws.environment
//  network_acl_id = data.terraform_remote_state.env_vpc.outputs.public_NACL
//  rule_number = 204
//  egress = false
//  protocol = "-1"
//  rule_action = "allow"
//  cidr_block = data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr
//  from_port = "0"
//  to_port = "0"
//}
//
//resource "aws_network_acl_rule" "intersite-to-env-private" {
//  provider = aws.environment
//  network_acl_id = data.terraform_remote_state.env_vpc.outputs.private_NACL
//  rule_number = 205
//  egress = false
//  protocol = "-1"
//  rule_action = "allow"
//  cidr_block = data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr
//  from_port = "0"
//  to_port = "0"
//}
//
//resource "aws_network_acl_rule" "intersite-to-env-db" {
//  provider = aws.environment
//  network_acl_id = data.terraform_remote_state.env_vpc.outputs.private_db_NACL
//  rule_number = 206
//  egress = false
//  protocol = "-1"
//  rule_action = "allow"
//  cidr_block = data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr
//  from_port = "0"
//  to_port = "0"
//}
//
//resource "aws_network_acl_rule" "env-to-intersite-ephemeral-out-pub" {
//  provider = aws.environment
//  network_acl_id = data.terraform_remote_state.env_vpc.outputs.public_NACL
//  rule_number = 204
//  egress = true
//  protocol = "-1"
//  rule_action = "allow"
//  cidr_block = data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr
//  from_port = "49152"
//  to_port = "65535"
//}
//
//resource "aws_network_acl_rule" "env-to-intersite-ephemeral-out-private" {
//  provider = aws.environment
//  network_acl_id = data.terraform_remote_state.env_vpc.outputs.private_NACL
//  rule_number = 205
//  egress = true
//  protocol = "-1"
//  rule_action = "allow"
//  cidr_block = data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr
//  from_port = "49152"
//  to_port = "65535"
//}
//
//resource "aws_network_acl_rule" "env-to-intersite-ephemeral-out-private-db" {
//  provider = aws.environment
//  network_acl_id = data.terraform_remote_state.env_vpc.outputs.private_db_NACL
//  rule_number = 206
//  egress = true
//  protocol = "-1"
//  rule_action = "allow"
//  cidr_block = data.terraform_remote_state.intersite_vpc.outputs.vpc_cidr
//  from_port = "49152"
//  to_port = "65535"
//}
