## 0.2.1

- Improved performance

## 0.2.0

- Simplified API
  - Added `#text`, `#html`, `#tag` methods
  - No longer use `#method_missing`

Before:

```rb
Htmlrb.build do |h|
  h.a href: "http://yurucamp.jp", class: "Yuru Camp△", target: "_blank" do
    "Yuru Camp△"
  end
end
```

After:

```rb
Htmlrb.build do |h|
  h.tag :a, href: "http://yurucamp.jp", class: "Yuru Camp△", target: "_blank" do
    h.text "Yuru Camp△"
  end
end
```

## 0.1.0

- Initial release
