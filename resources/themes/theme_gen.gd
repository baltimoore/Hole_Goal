@tool
extends ProgrammaticTheme

const UPDATE_ON_SAVE = true
const VERBOSITY = Verbosity.QUIET

# Color palette
var primary_purple = Color("#7c3aed")
var light_purple = Color("#a78bfa")
var dark_purple = Color("#5b21b6")
var accent_purple = Color("#ddd6fe")

var text_primary = Color("#ffffff")
var text_secondary = Color("#e9d5ff")
var background_dark = Color("#1f1f2e")
var background_lighter = Color("#2d2d3d")
var background_darker = Color("#0f0f1a")
var border_color = Color("#5b21b6")

# Typography
var default_font_size = 14
var large_font_size = 18
var small_font_size = 12

var default_border_width = 2
var corner_radius_value = 6
var default_margin_v = 10
var default_margin_h = 20

func setup():
	set_save_path("res://resources/themes/generated/generated_theme.tres")

func define_theme():
	define_default_font_size(default_font_size)

	# ========== BUTTONS ==========
	var button_normal = stylebox_flat({
		bg_color = primary_purple,
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margin_top = default_margin_v,
		content_margin_bottom = default_margin_v,
		content_margin_left = default_margin_h,
		content_margin_right = default_margin_h
	})

	var button_hover = inherit(button_normal, {
		bg_color = light_purple
	})

	var button_pressed = inherit(button_normal, {
		bg_color = dark_purple
	})

	var button_focus = stylebox_flat({
		bg_color = primary_purple,
		border_color = accent_purple,
		border_ = border_width(3),
		corner_radius_ = corner_radius(corner_radius_value)
	})

	define_style("Button", {
		normal = button_normal,
		hover = button_hover,
		pressed = button_pressed,
		focus = button_focus,
		font_color = text_primary,
		font_size = default_font_size
	})

	# ========== LABELS ==========
	define_style("Label", {
		font_color = text_primary,
		font_size = default_font_size,
		line_spacing = 4
	})

	# ========== LINE EDIT (Text Input) ==========
	var lineedit_normal = stylebox_flat({
		bg_color = background_darker,
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(12, 8, 12, 8)
	})

	var lineedit_focus = inherit(lineedit_normal, {
		border_color = light_purple,
		border_ = border_width(3)
	})

	define_style("LineEdit", {
		normal = lineedit_normal,
		focus = lineedit_focus,
		font_color = text_primary,
		font_size = default_font_size,
		caret_color = accent_purple
	})

	# ========== TEXT EDIT (Multiline Text Input) ==========
	var textedit_normal = stylebox_flat({
		bg_color = Color("#0f0f1a"),
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(12, 12, 12, 12)
	})

	var textedit_focus = inherit(textedit_normal, {
		border_color = light_purple,
		border_ = border_width(3)
	})

	define_style("TextEdit", {
		normal = textedit_normal,
		focus = textedit_focus,
		font_color = text_primary,
		font_size = default_font_size,
		caret_color = accent_purple,
		line_spacing = 4
	})

	# ========== PANEL CONTAINER ==========
	define_style("PanelContainer", {
		panel = stylebox_flat({
			bg_color = background_lighter,
			border_color = border_color,
			border_ = border_width(default_border_width),
			corner_radius_ = corner_radius(corner_radius_value),
			expand_margins_ = expand_margins(12)
		})
	})

	# ========== CHECK BOX ==========
	var checkbox_normal = stylebox_flat({
		bg_color = background_darker,
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(4)
	})

	var checkbox_pressed = inherit(checkbox_normal, {
		bg_color = primary_purple
	})

	var checkbox_focus = inherit(checkbox_normal, {
		border_color = accent_purple,
		border_ = border_width(3)
	})

	define_style("CheckBox", {
		normal = checkbox_normal,
		normal_mirrored = checkbox_normal,
		pressed = checkbox_pressed,
		pressed_mirrored = checkbox_pressed,
		focus = checkbox_focus,
		font_color = text_primary,
		font_size = default_font_size
	})

	# ========== OPTION BUTTON (Dropdown) ==========
	var option_normal = stylebox_flat({
		bg_color = primary_purple,
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(12, 8, 12, 8)
	})

	var option_hover = inherit(option_normal, {
		bg_color = light_purple
	})

	var option_pressed = inherit(option_normal, {
		bg_color = dark_purple
	})

	var option_focus = stylebox_flat({
		bg_color = primary_purple,
		border_color = accent_purple,
		border_ = border_width(3),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(12, 8, 12, 8)
	})

	define_style("OptionButton", {
		normal = option_normal,
		hover = option_hover,
		pressed = option_pressed,
		focus = option_focus,
		font_color = text_primary,
		font_size = default_font_size
	})

	# ========== TAB BAR ==========
	var tab_normal = stylebox_flat({
		bg_color = background_lighter,
		border_color = border_color,
		border_ = border_width(1),
		corner_radius_ = corner_radius(corner_radius_value)
	})

	var tab_hover = inherit(tab_normal, {
		bg_color = Color("#3d3d4d")
	})

	var tab_active = stylebox_flat({
		bg_color = primary_purple,
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(corner_radius_value)
	})

	define_style("TabBar", {
		tab_normal = tab_normal,
		tab_hover = tab_hover,
		tab_active = tab_active,
		font_color = text_secondary,
		font_size = default_font_size
	})

	define_style("TabBar", {
		font_selected_color = text_primary
	})

	# ========== SCROLL CONTAINER ==========
	define_style("ScrollContainer", {
		panel = stylebox_flat({
			bg_color = background_darker,
			border_color = border_color,
			border_ = border_width(1),
			corner_radius_ = corner_radius(corner_radius_value)
		})
	})

	# ========== PROGRESS BAR ==========
	var progress_background = stylebox_flat({
		bg_color = background_darker,
		border_color = border_color,
		border_ = border_width(1),
		corner_radius_ = corner_radius(corner_radius_value)
	})

	var progress_fill = stylebox_flat({
		bg_color = primary_purple,
		corner_radius_ = corner_radius(corner_radius_value)
	})

	define_style("ProgressBar", {
		background = progress_background,
		fill = progress_fill
	})

	# ========== SPIN BOX ==========
	var spinbox_normal = stylebox_flat({
		bg_color = background_darker,
		border_color = border_color,
		border_ = border_width(default_border_width),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(12, 8, 12, 8)
	})

	var spinbox_focus = inherit(spinbox_normal, {
		border_color = light_purple,
		border_ = border_width(3)
	})

	define_style("SpinBox", {
		normal = spinbox_normal,
		focus = spinbox_focus,
		font_color = text_primary,
		font_size = default_font_size
	})

	# ========== SLIDER ==========
	define_style("HSlider", {
		slider = stylebox_flat({
			bg_color = primary_purple,
			border_color = border_color,
			border_ = border_width(1),
			corner_radius_ = corner_radius(4)
		}),
		grabber = stylebox_flat({
			bg_color = light_purple,
			border_color = accent_purple,
			border_ = border_width(2),
			corner_radius_ = corner_radius(6)
		}),
		grabber_highlight = stylebox_flat({
			bg_color = accent_purple,
			border_color = light_purple,
			border_ = border_width(2),
			corner_radius_ = corner_radius(6)
		})
	})

	define_style("VSlider", {
		slider = stylebox_flat({
			bg_color = primary_purple,
			border_color = border_color,
			border_ = border_width(1),
			corner_radius_ = corner_radius(4)
		}),
		grabber = stylebox_flat({
			bg_color = light_purple,
			border_color = accent_purple,
			border_ = border_width(2),
			corner_radius_ = corner_radius(6)
		}),
		grabber_highlight = stylebox_flat({
			bg_color = accent_purple,
			border_color = light_purple,
			border_ = border_width(2),
			corner_radius_ = corner_radius(6)
		})
	})

	# ========== TREE ==========
	var tree_normal = stylebox_flat({
		bg_color = background_darker,
		border_color = border_color,
		border_ = border_width(1),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(8, 8, 8, 8)
	})

	define_style("Tree", {
		panel = tree_normal,
		item_selected = stylebox_flat({
			bg_color = primary_purple,
			corner_radius_ = corner_radius(4)
		}),
		font_color = text_primary,
		font_size = default_font_size
	})

	# ========== ITEM LIST ==========
	var itemlist_normal = stylebox_flat({
		bg_color = background_darker,
		border_color = border_color,
		border_ = border_width(1),
		corner_radius_ = corner_radius(corner_radius_value),
		content_margins_ = content_margins(8, 8, 8, 8)
	})

	define_style("ItemList", {
		panel = itemlist_normal,
		item_selected = stylebox_flat({
			bg_color = primary_purple,
			corner_radius_ = corner_radius(4)
		}),
		font_color = text_primary,
		font_size = default_font_size
	})

	# ========== TITLE VARIANT ==========
	define_variant_style("Title", "Label", {
		font_size = large_font_size,
		font_color = accent_purple
	})

	# ========== SMALL TEXT VARIANT ==========
	define_variant_style("Small", "Label", {
		font_size = small_font_size,
		font_color = text_secondary
	})

	# ========== PRIMARY BUTTON VARIANT ==========
	define_variant_style("PrimaryButton", "Button", {
		normal = inherit(button_normal, {
			bg_color = primary_purple
		}),
		hover = inherit(button_hover, {
			bg_color = light_purple
		}),
		pressed = inherit(button_pressed, {
			bg_color = dark_purple
		})
	})

	# ========== DANGER BUTTON VARIANT ==========
	define_variant_style("DangerButton", "Button", {
		normal = stylebox_flat({
			bg_color = Color("#dc2626"),
			border_color = Color("#991b1b"),
			border_ = border_width(default_border_width),
			corner_radius_ = corner_radius(corner_radius_value)
		}),
		hover = stylebox_flat({
			bg_color = Color("#ef4444"),
			border_color = Color("#991b1b"),
			border_ = border_width(default_border_width),
			corner_radius_ = corner_radius(corner_radius_value)
		}),
		pressed = stylebox_flat({
			bg_color = Color("#991b1b"),
			border_color = Color("#7f1d1d"),
			border_ = border_width(default_border_width),
			corner_radius_ = corner_radius(corner_radius_value)
		}),
		font_color = text_primary
	})
