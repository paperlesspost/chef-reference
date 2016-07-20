# How to use Paperless Post's fork of Chef Reference to bring up a Chef server in AWS:

1. install Chef DK (** NOTE you may need to use an old version - should test 0.9.0)
2. git clone git@github.com:paperlesspost/chef-reference.git
3. follow instructions on https://github.com/chef-cookbooks/chef-reference/blob/master/docs/secrets.md to create databags (**TODO store these somewhere)
4. follow instructions in [AWS Scenario docs](https://github.com/chef-cookbooks/chef-reference/blob/master/docs/scenario-aws.md) up to Rake task

What the rake task does:
1.  runs `chef provision --no-policy --recipe cluster -c .chef/config.rb` for each of the following roles:
server-backend server-frontend analytics supermarket compliance ** we should change to be only the roles we need

`chef provision` is a frontend for a chef-solo run, it uses solo so it doesn't try to sync cookbooks from a Chef Server. It instead uses cookbooks in this local directory. If not otherwise specified, `chef provision` will expect to find a cookbook named 'provision' in the current working directory.
* --no-policy means
* --recipe tells Chef to use the following recipe `provision/recipes/cluster.rb` 
* -c is the config file that points to our local chef-zero server instance.

PROBLEM: how do we override the attributes in provision/attributes/default without editing the cookbook directly?

ANSWER: create our own wrapper cookbook and tell `chef provision` to use it:
```
chef generate cookbook paperless-provision
```
and edit Rakefile.rb to use:
```
chef provision --cookbook paperless-provision --no-policy --recipe cluster -c .chef/config.rb
```




## SCRATCH:

```
  "override_attributes": {
      "chef": {
        "provisioning": {
          "server-backend-options": {
            "bootstrap_options": {
              "image_id": "ami-12663b7a",
              "subnet_id": "subnet-be7f5dd7",
              "security_group_ids": [
                "sg-34b4a658"
              ]
            }
          }
        }
      }
    },
```


