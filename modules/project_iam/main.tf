
locals {
  project_member_permissions = flatten([

    for m, member in var.project_members : [

      for role, permission in member.project_iam_permissions : {
        project = var.project_id
        role    = permission
        member  = lookup(member, "member_type", "WARNING-MEMBER-TYPE-NOT-FOUND") == "user" ? "user:${lookup(member, "member_name", "WARNING-MEMBER-TYPE-NOT-FOUND")}" : lookup(member, "member_type", "WARNING-MEMBER-TYPE-NOT-FOUND") == "serviceaccount" ? "serviceAccount:${lookup(member, "member_name", "WARNING-MEMBER-TYPE-NOT-FOUND")}" : lookup(member, "member_type", "WARNING-MEMBER-TYPE-NOT-FOUND") == "group" ? "group:${lookup(member, "member_name", "WARNING-MEMBER-TYPE-NOT-FOUND")}" : "domain:${lookup(member, "member_name", "WARNING-MEMBER-TYPE-NOT-FOUND")}"
      }
    ]
  ])
}

/******************************************
	Member Permissions
 *****************************************/
resource "google_project_iam_member" "this" {
  for_each = {
    # Generate a unique string identifier for each role
    for mr in local.project_member_permissions : "${mr.member}-${mr.role}" => mr
  }

  project = each.value.project
  member  = each.value.member
  role    = each.value.role
}
