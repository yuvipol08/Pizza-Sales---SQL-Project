-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

SELECT 
    name, 
    revenue 
FROM 
    (SELECT 
        category, 
        name, 
        revenue, 
        RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn 
     FROM 
        (SELECT 
            pizza_types.category,
            pizza_types.name,
            SUM((order_details.quantity) * pizzas.price) AS revenue
         FROM 
            pizza_types
                JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
                JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
         GROUP BY 
            pizza_types.category, pizza_types.name) AS a) AS b
WHERE 
    rn <= 3;