class DropdownItem<T> {
  final T value;
  final String text;

  DropdownItem(
    this.value,
    this.text,
  );

  factory DropdownItem.fromJson(dynamic json) => DropdownItem(
        json['value'] as T,
        json['text'] as String,
      );
}
