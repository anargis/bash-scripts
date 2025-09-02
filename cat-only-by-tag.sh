#!/usr/bin/env bash
# Runs a wp eval with embedded PHP to keep ONLY the Outlet category
# for products tagged with summer-2025. Edit slugs if needed.

# change the tag slug: summer-2025 (lines 9 & 10)
# change the cat slug: outlet (line 12)

wp eval '
$tag = get_term_by("slug","summer-2025","product_tag");
if(!$tag){ exit("ERROR: product_tag slug summer-2025 not found\n"); }

$outlet = get_term_by("slug","outlet","product_cat");
if(!$outlet){ exit("ERROR: OUTLET category not found\n"); }

$q = new WP_Query([
  "post_type"=>"product","posts_per_page"=>-1,"fields"=>"ids",
  "tax_query"=>[[ "taxonomy"=>"product_tag","field"=>"term_id","terms"=>[$tag->term_id] ]],
]);

$set=0; $swept=0;
foreach($q->posts as $id){
  $res = wp_set_object_terms($id, [$outlet->term_id], "product_cat", false);
  if (is_wp_error($res)) { echo "ERR $id: ".$res->get_error_message()."\n"; continue; }

  $have = wp_get_object_terms($id, "product_cat", ["fields"=>"ids"]);
  $extra = array_diff($have, [$outlet->term_id]);
  if ($extra) { wp_remove_object_terms($id, $extra, "product_cat"); $swept++; }
  $set++;
}
echo "Set ONLY OUTLET for $set products; removed lingering extras on $swept products.\n";
'
