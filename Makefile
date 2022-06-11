# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tzeck <@student.42heilbronn.de>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/01 00:09:38 by tom               #+#    #+#              #
#    Updated: 2022/06/11 21:02:11 by tzeck            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# EXECUTABLE
NAME = ./miniRT

# FLAGS
CC = gcc
CFLAGS = -Wall -Wextra -fsanitize=address #-Werror

# COLORS
Y = "\033[33m"
R = "\033[31m"
G = "\033[32m"
B = "\033[34m"
X = "\033[0m"
UP = "\033[A"
CUT = "\033[K"

# PATHS
SRC_PATH = ./src/
PARS_PATH = ./src/parser/
OBJ_PATH = ./obj/
MLX_PATH = ./MLX42/
GLFW_PATH = ~/.brew/opt/glfw/lib/

# SOURCES
SRC =	$(SRC_PATH)main.c\
		$(PARS_PATH)init_data.c	$(PARS_PATH)utils.c

# OBJECTS
OBJ = $(patsubst $(SRC_PATH)%.c, $(OBJ_PATH)%.o, $(SRC))

# RULES
all: $(NAME)
	@sleep 0.1
	@echo $(B)"                                                           "$(X)
	@sleep 0.1
	@echo $(B)"           ,--.          ,--. ,------.  ,--------.         "$(X)
	@sleep 0.1
	@echo $(B)",--,--,--. \`--' ,--,--,  \`--' |  .--. ' '--.  .--'       "$(X)
	@sleep 0.1
	@echo $(B)"|        | ,--. |      \ ,--. |  '--'.'    |  |            "$(X)
	@sleep 0.1
	@echo $(B)"|  |  |  | |  | |  ||  | |  | |  |\  \     |  |            "$(X)
	@sleep 0.1
	@echo $(B)"\`--\`--\`--' \`--' \`--''--' \`--' \`--' '--'    \`--'    "$(X)
	@sleep 0.1
	@printf "\n\n"

$(OBJ_PATH)%.o :$(SRC_PATH)%.c
	@echo $(Y)Compiling [$@]...$(X)
	@mkdir -p $(dir $@)
	@printf $(UP)$(CUT)
	@$(CC) $(CFLAGS) -c -o $@ $<
	@echo $(G)Finished [$@]$(X)
	@printf $(UP)$(CUT)

$(NAME): $(OBJ)
	@make -C MLX42
	@make -C libft
	@$(CC) $(CFLAGS) $(OBJ) $(MLX_PATH)libmlx42.a -lglfw -L $(GLFW_PATH) -o $(NAME)
	@echo $(G)Finished [$(NAME)]$(X)

clean:
	@make clean -C MLX42
	@make clean -C libft
	@if [ -d "$(OBJ_PATH)" ]; then \
			rm -f -r $(OBJ_PATH); \
			echo $(R)Cleaning" "[$(OBJ) $(OBJ_PATH)]$(X); else \
			echo "No objects to remove."; \
	fi;

fclean: clean
	@make fclean -C MLX42
	@make fclean -C libft
	@if [ -f "$(NAME)" ]; then \
			rm -f $(NAME); \
			echo $(R)Cleaning" "[$(NAME)]$(X);else \
			echo "No executable to remove."; \
	fi;

re: fclean all

.PHONY: all, clean, fclean, re
