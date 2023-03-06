NAME = minirt

CC = cc
CFLAGS = -Wall -Wextra -Werror
RM = rm
RMFLAGS = -f

MATHLIBOPTION = -lm

HEADERS = -I$(INCLUDE)

BONUS_HEADERS = -I$(BONUS_INCLUDES)

INCLUDE = ./include

BONUS_INCLUDES = ./bonus_includes

MLX_MACOS = ./mlx

MLX_FLAG_CLUSTER_MACOS = -Lmlx -lmlx -framework OpenGL -framework AppKit 

LIBFT = ./libft

LIBFT_FLAG = -Llibft -lft

SRCDIR = ./src

BONUS_SRCDIR = ./bonus_src

# BONUS_SRC_MAIN_DIR	= $(BONUS_SRCDIR)/main
# BONUS_SRC_DRAW_DIR	= $(BONUS_SRCDIR)/draw
# BONUS_SRC_MLX_DIR		= $(BONUS_SRCDIR)/mlx
# BONUS_SRC_PARSER_DIR	= $(BONUS_SRCDIR)/parsing
# BONUS_SRC_PROJECTION_DIR	= $(BONUS_SRCDIR)/projection
# BONUS_SRC_TRANSFORM_DIR	= $(BONUS_SRCDIR)/transform
# BONUS_SRC_SCENE_OBJ_DIR		= $(BONUS_SRCDIR)/scene_obj

# BONUS_SRC_MAIN	= main_bonus.c error_bonus.c
# BONUS_SRC_MAIN	:= $(addprefix $(BONUS_SRC_MAIN_DIR)/, $(BONUS_SRC_MAIN))

# BONUS_SRC_DRAW	= draw_main_bonus.c draw_line_bonus.c draw_util_bonus.c
# BONUS_SRC_DRAW	:= $(addprefix $(BONUS_SRC_DRAW_DIR)/, $(BONUS_SRC_DRAW))

# BONUS_SRC_MLX		= mlx_set_bonus.c mlx_key_bonus.c mlx_key_operations_bonus.c mlx_key_operations2_bonus.c
# BONUS_SRC_MLX		:= $(addprefix $(BONUS_SRC_MLX_DIR)/,$(BONUS_SRC_MLX))

# BONUS_SRC_PARSER	= get_next_line_bonus.c parser_bonus.c parser2_bonus.c parser_util_bonus.c
# BONUS_SRC_PARSER 	:= $(addprefix $(BONUS_SRC_PARSER_DIR)/,$(BONUS_SRC_PARSER))

# BONUS_SRC_PROJECTION	= projection_bonus.c init_cam_bonus.c cam_bonus.c cam_util_bonus.c
# BONUS_SRC_PROJECTION	:= $(addprefix $(BONUS_SRC_PROJECTION_DIR)/, $(BONUS_SRC_PROJECTION))

# BONUS_SRC_TRANSFORM	= init_transform_matrices_bonus.c rotation_matrix_bonus.c transform_util_bonus.c translate_matrix_bonus.c set_transform_matrix_bonus.c set_transform_matrix2_bonus.c
# BONUS_SRC_TRANSFORM	:= $(addprefix $(BONUS_SRC_TRANSFORM_DIR)/, $(BONUS_SRC_TRANSFORM))

# BONUS_SRC_SCENE_OBJ	= init_scene_obj_bonus.c set_scene_obj_coordinate_bonus.c world_guide_bonus.c
# BONUS_SRC_SCENE_OBJ	:= $(addprefix $(BONUS_SRC_SCENE_OBJ_DIR)/, $(BONUS_SRC_SCENE_OBJ))

# BONUS_SRCS = $(BONUS_SRC_MAIN) $(BONUS_SRC_DRAW) $(BONUS_SRC_MLX) $(BONUS_SRC_PARSER) $(BONUS_SRC_PROJECTION) $(BONUS_SRC_TRANSFORM) $(BONUS_SRC_SCENE_OBJ)


SRC_MAIN_DIR	= $(SRCDIR)/main
# SRC_DRAW_DIR	= $(SRCDIR)/draw
# SRC_MLX_DIR		= $(SRCDIR)/mlx
# SRC_PARSER_DIR	= $(SRCDIR)/parsing
# SRC_PROJECTION_DIR	= $(SRCDIR)/projection
# SRC_TRANSFORM_DIR	= $(SRCDIR)/transform
# SRC_SCENE_OBJ_DIR		= $(SRCDIR)/scene_obj

SRC_MAIN	= main.c
SRC_MAIN	:= $(addprefix $(SRC_MAIN_DIR)/, $(SRC_MAIN))

# SRC_DRAW	= draw_main.c draw_line.c draw_util.c
# SRC_DRAW	:= $(addprefix $(SRC_DRAW_DIR)/, $(SRC_DRAW))

# SRC_MLX		= mlx_set.c mlx_key.c
# SRC_MLX		:= $(addprefix $(SRC_MLX_DIR)/,$(SRC_MLX))

# SRC_PARSER	= get_next_line.c parser.c parser2.c parser_util.c
# SRC_PARSER 	:= $(addprefix $(SRC_PARSER_DIR)/,$(SRC_PARSER))

# SRC_PROJECTION	= projection.c init_cam.c
# SRC_PROJECTION	:= $(addprefix $(SRC_PROJECTION_DIR)/, $(SRC_PROJECTION))

# SRC_TRANSFORM	= init_transform_matrices.c rotation_matrix.c transform_util.c translate_matrix.c set_transform_matrix.c set_transform_matrix2.c
# SRC_TRANSFORM	:= $(addprefix $(SRC_TRANSFORM_DIR)/, $(SRC_TRANSFORM))

# SRC_SCENE_OBJ	= init_scene_obj.c set_scene_obj_coordinate.c world_guide.c
# SRC_SCENE_OBJ	:= $(addprefix $(SRC_SCENE_OBJ_DIR)/, $(SRC_SCENE_OBJ))

SRCS = $(SRC_MAIN) $(SRC_DRAW) $(SRC_MLX) $(SRC_PARSER) $(SRC_PROJECTION) $(SRC_TRANSFORM) $(SRC_SCENE_OBJ)


BONUS_OBJS = $(BONUS_SRCS:.c=.o)

OBJS = $(SRCS:.c=.o)


ifdef DO_BONUS
	OBJECTS = $(BONUS_OBJS)
else
	OBJECTS = $(OBJS)
endif


all : $(NAME)

$(NAME): $(OBJECTS)
	make -C $(MLX_MACOS) all
	make -C $(LIBFT) bonus
	$(CC) $(CFLAGS) $(DEBUG) $(OBJECTS) $(MATHLIBOPTION) $(MLX_FLAG_CLUSTER_MACOS) $(LIBFT_FLAG) -o $(NAME)

%.o	: %.c
	$(CC) $(CFLAGS) $(DEBUG) $(HEADERS) -Ilibft -Imlx -c $< -o $@

bonus: 
	make DO_BONUS=1 all
	
clean:
	make -C $(MLX_MACOS) clean
	make -C $(LIBFT) clean
	$(RM) $(RMFLAGS) $(OBJS) $(BONUS_OBJS)

fclean: clean
	$(RM) $(RMFLAGS) $(MLX_MACOS)/libmlx.a
	$(RM) $(RMFLAGS) $(LIBFT)/libft.a
	$(RM) $(RMFLAGS) $(NAME)

re: 
	make fclean 
	make all

.PHONY: all bonus clean fclean re