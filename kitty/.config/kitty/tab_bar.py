"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_title,
)
from kitty.utils import color_as_int

opts = get_options()

# Define colors
TABBAR_BG = as_rgb(color_as_int(opts.tab_bar_background or opts.color0))
ACTIVE_BG = as_rgb(color_as_int(opts.active_tab_background or opts.color8))
ACTIVE_FG = as_rgb(color_as_int(opts.active_tab_foreground or opts.color4))
INACTIVE_BG = as_rgb(color_as_int(opts.inactive_tab_background or opts.color12))
INACTIVE_FG = as_rgb(color_as_int(opts.inactive_tab_foreground or opts.color7))
ACTIVE_WINDOW_BG = as_rgb(color_as_int(opts.color6))

SEPARATOR = "▎"

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    _draw_left_status(draw_data, screen, tab, index, extra_data)

    if is_last:
        _draw_right_status(screen)

    return screen.cursor.x

def _draw_right_status(screen: Screen) -> int:
    tab_manager = get_boss().active_tab_manager
    cells = []

    if tab_manager is not None:
        windows = tab_manager.active_tab.windows.all_windows
        if windows is not None:
            for i, window in enumerate(windows):
                is_active = window.id == tab_manager.active_window.id
                sup = to_sup(str(i + 1))

                window_fg = ACTIVE_FG if is_active else INACTIVE_FG
                window_bg = ACTIVE_WINDOW_BG if is_active else INACTIVE_BG

                cells.append((window_fg, window_bg, f" {sup} {window.title} "))
                cells.append((INACTIVE_FG, INACTIVE_BG, SEPARATOR))

    # Calculate and draw leading spaces
    right_status_length = sum(len(cell) for _, _, cell in cells)
    leading_spaces = screen.columns - screen.cursor.x - right_status_length

    if leading_spaces > 0:
        screen.draw(" " * leading_spaces)

    # Draw right status
    for fg, bg, cell in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(cell)

    screen.cursor.fg = 0
    screen.cursor.bg = 0
    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)

    return screen.cursor.x

def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    index: int,
    extra_data: ExtraData,
) -> int:
    tab_bg = screen.cursor.bg
    next_tab_bg = (as_rgb(draw_data.tab_bg(extra_data.next_tab)) 
                  if extra_data.next_tab 
                  else as_rgb(int(draw_data.default_bg)))

    screen.cursor.bg = tab_bg
    draw_title(draw_data, screen, tab, index)
    screen.draw(" ")
    screen.cursor.fg = INACTIVE_FG
    screen.cursor.bg = next_tab_bg
    screen.draw(SEPARATOR)

    return screen.cursor.x

def to_sup(s: str) -> str:
    sups = {
        '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
        '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹'
    }
    return ''.join(sups.get(char, char) for char in s)
