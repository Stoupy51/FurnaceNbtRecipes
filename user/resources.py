
# ruff: noqa: E501
# Imports
from beet import Advancement, FunctionTag
from stewbeet import Context, JsonDict, set_json_encoder


# Setup json resources (advancement, function tags)
def setup_resources(ctx: Context) -> None:
	ns: str = ctx.project_id
	version: str = ctx.project_version

	json_content: JsonDict

	json_content = {"criteria":{"requirement":{"trigger":"minecraft:placed_block","conditions":{"location":[{"condition":"minecraft:location_check","predicate":{"block":{"blocks":f"#{ns}:furnaces"}}}]}}},"requirements":[["requirement"]],"rewards":{"function":f"{ns}:v{version}/advancements/placed_furnace"}}
	ctx.data[ns].advancements[f"v{version}/placed_furnace"] = set_json_encoder(Advancement(json_content), max_level=-1)

	json_content = {"values":[]}
	ctx.data[ns].function_tags["v1/blasting_recipes"] = set_json_encoder(FunctionTag(json_content))

	json_content = {"values":[]}
	ctx.data[ns].function_tags["v1/disable_cooking"] = set_json_encoder(FunctionTag(json_content))

	json_content = {"values":[]}
	ctx.data[ns].function_tags["v1/recipes_used"] = set_json_encoder(FunctionTag(json_content))

	json_content = {"values":[]}
	ctx.data[ns].function_tags["v1/smelting_recipes"] = set_json_encoder(FunctionTag(json_content))

	json_content = {"values":[]}
	ctx.data[ns].function_tags["v1/smoking_recipes"] = set_json_encoder(FunctionTag(json_content))

