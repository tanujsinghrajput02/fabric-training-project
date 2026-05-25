[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "orders_bronze_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "order_date", DestinationColumnName = "order_date"], [SourceColumnName = "quantity", DestinationColumnName = "quantity"], [SourceColumnName = "order_amount", DestinationColumnName = "order_amount"], [SourceColumnName = "status", DestinationColumnName = "status"], [SourceColumnName = "year_month", DestinationColumnName = "year_month"], [SourceColumnName = "revenue_band", DestinationColumnName = "revenue_band"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared orders_bronze = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "53dcddee-1a16-4051-9e0a-bed919d06fe7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "a5ad8e27-69d7-4cc7-b6c5-8739f73197d7"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "orders_bronze", ItemKind = "Table"]}[Data],
  #"Filtered rows" = Table.SelectRows(#"Navigation 2", each ([order_amount] <> null and [order_amount] <> "0")),
  #"Changed column type" = Table.TransformColumnTypes(#"Filtered rows", {{"order_amount", type number}}),
  #"Inserted conditional column" = Table.AddColumn(#"Changed column type", "Custom", each if [order_amount] > 1000 then "High" else "Low"),
  #"Renamed columns" = Table.RenameColumns(#"Inserted conditional column", {{"Custom", "revenue_band"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns", {{"order_id", Int64.Type}, {"customer_id", Int64.Type}, {"product_id", Int64.Type}, {"quantity", Int64.Type}, {"revenue_band", type text}})
in
  #"Changed column type 1";
shared orders_bronze_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "53dcddee-1a16-4051-9e0a-bed919d06fe7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "a5ad8e27-69d7-4cc7-b6c5-8739f73197d7"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "orders_silver", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
