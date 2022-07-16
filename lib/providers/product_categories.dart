class ProductCategories {
  final String CategoryId;
  final String CategoryTitle;
  final String CategoryImage;

  ProductCategories(this.CategoryId, this.CategoryTitle, this.CategoryImage);
}

final categoryData = [
  ProductCategories("V", "Vehicles",
      "https://media.istockphoto.com/vectors/car-icon-auto-vehicle-isolated-transport-icons-automobile-silhouette-vector-id1273534607?k=20&m=1273534607&s=612x612&w=0&h=Uynt53JLF7_JUxklSlCNP-KVm-CNLUkgpgewc2AOO2I="),
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6VKUoxcKm65J4NScLCvPSCwcCFCHjB8RJPkperho9bztYtXe4lPisXU1G0DrSgx39Z0I&usqp=CAU"),
  ProductCategories("E", "Appliances",
      "https://us.123rf.com/450wm/anthonycz/anthonycz1307/anthonycz130700089/21434177-drill-icon.jpg?ver=6"),
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlgo6Q1FSSKHf__zRWmF7lx51qW7KjxyiH3g&usqp=CAU"),
  ProductCategories(
      "U",
      "Utensils",
      // "https://img.myloview.com/posters/kitchen-plate-icon-outline-kitchen-plate-vector-icon-for-web-design-isolated-on-white-background-400-226311304.jpg"),
      // "https://thumbs.dreamstime.com/z/clean-plates-isolated-background-table-group-large-white-objects-background-set-112153309.jpg"),
      "https://cdn1.vectorstock.com/i/1000x1000/25/55/bowls-icon-vector-24722555.jpg"),
  ProductCategories("C", "Clothes",
      "https://cdn2.vectorstock.com/i/thumb-large/45/86/polo-shirt-icon-simple-style-vector-8874586.jpg"),
  // "https://media.istockphoto.com/vectors/colorful-pile-of-dress-vector-id1075970468?b=1&k=20&m=1075970468&s=612x612&w=0&h=yM_HTnxOD9N1Oor8ieXJdpUqbt9VYHlgSdD99oXVZUo="),
];
