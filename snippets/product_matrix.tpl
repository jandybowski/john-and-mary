<script type="text/javascript">
	var shippingDefault = "{$settings->shipping_info}";
	
	var variants = [];
	var properties = [];
	var productProperties = [];
	
	
	function Property(name, value) {
		this.name = name;
		this.value = value;
		
	}
	function Variant(productId, id, name, price, priceRegular, quantity, image, shipping, sku) {
		this.productId = productId;
		this.id = id;
		this.name = name;
		this.price = price;
		this.priceRegular = priceRegular;
		this.quantity = quantity;
		this.properties = [];
		this.image = image;
		this.shipping = shipping;
		this.sku = sku;
		this.getProperty = function(prop) {
			for(p=0;p < this.properties.length;p++) {
				if(typeof(prop)=="string") {
					if(this.properties[p].value == prop) {
						return this.properties[p];
					}
				} else {
					if(this.properties[p].name == prop.name && this.properties[p].value == prop.value) {
						return this.properties[p];
					}
				}
				
			}
			return null;
		};
		this.hasProperty = function(prop) {
			if(this.getProperty(prop) !== null) return true;
			return false;
		}
	}
	
	function getProperty(propName, propValue) {
		for(i=0;i < properties.length;i++) {
			if(properties[i].name == propName && properties[i].value == propValue) {
				return properties[i];
			}
		}
		return null;
	}
	function getVariant(value) {
		if(typeof(value) == "number") {
			for(i=0;i < variants.length;i++) {
				if(variants[i].id == value) {
					return variants[i];
				}
			}
		} else if(typeof(value) == "object") {
			for(i=0;i < variants.length;i++) {
				var len = 0;
				for(j=0;j < value.length;j++) {
					if(variants[i].hasProperty(value[j])) {
						
						len+=1;
					}
				}
				if(len==variants[i].properties.length) return variants[i]

			}
		}
		return null;
	}
	
	function getVariants(value) {
		var vars = [];
		if(typeof(value) == "number") {
			for(var i=0;i < variants.length;i++) {
				if(variants[i].productId == value) {
					vars.push(variants[i])
				}
			}
		} else if(typeof(value) == "object") {
			for(var i=0;i < variants.length;i++) {
				var len = 0;
				for(j=0;j < value.length;j++) {
					if(variants[i].hasProperty(value[j])) {
						len+=1;
					}
				}
				if(len==value.length) vars.push(variants[i]);

			}
		}
		return vars.length > 0 ? vars : null;
	}
{foreach from=$product->properties key="property_name" item="property_values" name="loop"}
var propertyObj = [];
{foreach from=$property_values item="property_value"}
	properties.push(new Property("{$property_name}", "{$property_value}"));
	propertyObj.push("{$property_value}")
{/foreach}
 	productProperties["{$property_name}"] = propertyObj;
{/foreach}
	
	var variant = null;
{foreach from=$variants item="variant"}
{if $variant->available}
	variant = new Variant({$product->id}, {$variant->id}, "{$product->name|strip_tags}", '{$variant->price|money_without_currency}', '{$variant->price_regular|money_without_currency}', '{$variant->quantity}', '{$variant->main_image|product_img_url:th100}', "{$variant->availability_description}", '{$variant->sku}');
{foreach from=$variant->properties key="property_name" item="property_value" name="loop"}
	variant.properties.push(getProperty("{$property_name}", "{$property_value}"));
{/foreach}
	variants.push(variant);
	
{/if}
{/foreach}
</script>	