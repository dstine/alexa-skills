resource "aws_resourcegroups_group" "group" {
  name = "alexa-skills"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "project",
      "Values": ["alexa-skills"]
    }
  ]
}
JSON
  }

  tags = {
    project   = "alexa-skills"
    terraform = true
  }
}

