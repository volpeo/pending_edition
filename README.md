# Pending Edition

## Migration

You need a field `published_at:datetime` and `published_id:integer:index` on your model.

## Methods

- `#publish`: save the draft and copy it in another instance
- `#unpublish`: destroy the published version of the instance
- `#editable`: get the editable version of the instance
- `#publishable`: get the publishable version of the instance
- `#editable?`
- `#publishable?`

## Example

```
# Create a post
Post.create(title: "Hello World")

# Retrieve editables posts
post = Post.editables.first

# Publish the post
post.publish

# Retrieve the published version
post.publishable
# or
Post.published.first

# Unpublish post
post.publishable.unpublish
```