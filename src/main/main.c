/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kshim <kshim@student.42seoul.kr>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/03/06 15:28:38 by kshim             #+#    #+#             */
/*   Updated: 2023/03/06 16:35:50 by kshim            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


#include <sys/time.h>
#include <stdio.h>

// 벡터 구조체 반환, 벡터 버퍼 사용 속도 비교하기.
typedef struct s_vector{
	float	x;
	float	y;
	float	z;
}	t_vec;

t_vec	ft_vec_stack(float x, float y, float z)
{
	t_vec	tmp;
	
	tmp.x = x;
	tmp.y = y;
	tmp.z = z;
	return (tmp);
}

void	ft_vec_ptr(t_vec *vec, float x, float y, float z)
{
	vec->x = x;
	vec->y = y;
	vec->z = z;
}

int main(int argc, char **argv)
{
	struct timeval	buf;
	u_int64_t		start;
	u_int64_t		end;
	int				iter;
	int				max_iter;
	t_vec			stack;
	
	if (argc == 100)
	{
		argv = 0;
		return (1);
	}
	max_iter = 800 * 600 * 40;
	iter = 0;
	gettimeofday(&buf, 0);
	start = buf.tv_sec * 1000000 + buf.tv_usec;
	while (iter < max_iter)
	{
		ft_vec_stack(23.3213, 23.56545234 , 13123.93412312);
		iter++;
	}
	gettimeofday(&buf, 0);
	end = buf.tv_sec * 1000000 + buf.tv_usec;
	printf("struct - 1 math - %llu\n", end - start);

	iter = 0;
	gettimeofday(&buf, 0);
	start = buf.tv_sec * 1000000 + buf.tv_usec;
	while (iter < max_iter)
	{
		ft_vec_ptr(&stack, 23.3213, 23.56545234 , 13123.93412312);
		iter++;
		ft_vec_ptr(&stack, 0, 0, 0);
		ft_vec_ptr(&stack, 0, 0, 0);
		ft_vec_ptr(&stack, 0, 0, 0);
	}
	gettimeofday(&buf, 0);
	end = buf.tv_sec * 1000000 + buf.tv_usec;
	printf("struct - 2 math - %llu\n", end - start);

	return (0);
}
