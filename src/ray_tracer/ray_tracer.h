#ifndef RAY_TRACER_H
# define RAY_TRACER_H

# include "../../includes/miniRT.h"

/**
 * @param  t: smallest intersection distance
 * @param  rgb: color struct from closest intersection object
 */
typedef struct s_tval
{
	float		t;
	t_vector	hit_point;
	t_color		rgb;
	int			obj_i;
	int			obj_type;
}	t_tval;

typedef struct s_cy
{
	t_vector	h;
	t_vector	l;
	t_vector	axis;
	t_vector	w;
	float		a;
	float		b;
	float		c;
	float		dist;
}	t_cy;

t_tval		intersection(t_ray ray, t_objects *objs, bool flag);

/*	SPHERE	*/

t_tval		sphere_loop(t_ray ray, t_objects *objs);
t_vector	get_sphere_normal(t_sp_list sp_node, t_tval tval, t_ray ray);

/*	PLANE	*/

t_tval		plane_loop(t_ray ray, t_objects *objs);
float		ray_plane(t_ray ray, t_pl_list *plane);
t_vector	get_plane_normal(t_pl_list pl_node, t_ray ray);

/*	CYLINDER	*/

t_tval		cylinder_loop(t_ray ray, t_objects *objs);
bool		mcheck(float t, t_ray ray, t_cy_list *cylinder, t_vector axis);
float		caps_check(t_ray ray, t_cy_list *cylinder);
float		caps_hit(t_ray ray, float rad, t_pl_list *h_cap, t_pl_list *c_cap);
t_vector	get_cylinder_normal(t_objects *objs, t_cy_list cy_node, t_tval tval, t_ray ray);
t_cy		cy_calc(t_ray ray, t_cy_list *cylinder);

/*	UTILS	*/

int			min(int n1, int n2);
int			get_color(t_color rgb, t_amb_light *amb, t_dir_light *dir);
int			init_shading(t_tval point, t_ray ray, t_objects *objs);

#endif