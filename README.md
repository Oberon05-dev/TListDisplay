# TListDisplay
Custom component for Delphi. This is two list combine in one object which exist separately without user mouse inputs.

| Column: 0 | Column: 1 |
| ----- | ------ |
| Id: 0 | Id: 0 |
| Id: 1 | Id: 1 |
| Id: 2 | Id: 2 |

## usage:

### **Consts:**<br />

| Name | Type | Usage |
| ----- | ------ | --- |
| `FShapes1` | TList | List of background shapes (Background cells) of column 1 |
| `FShapes2` | TList | List of background shapes (Background cells) of column 2 |
| `FLabels1` | TList | List of text elements of column 1 |
| `FLabels2` | TList | List of text elements of column 2 |
| `MyIni` | TIniFile | Ini file for save data for example position |

### **Procedures:**<br />
> **_Note:_** The parameter `Id` must be within the range of the list length of chosen column fo all procedures.
---
### `AddElement(ElementText1: string; Id, Column: Integer):`
Adds a new element (`ElementText1`) at position `Id` in the chosen list (`Column`). The parameter `Id` must be within the range of the list length. The procedure displays the new element.

> * `ElementText1` (type: string) - the text of the element to be added.<br />
> * `Id` (type: Integer) - the position at which the element should be added.<br />
> * `Column` (type: Integer) - the column number in which the element should be added.<br />

**Example:**
```Delphi
  TListDisplay.AddElement('Test3', 0, 0); // adds 'Test3' to row 1 column 1 
  TListDisplay.AddElement('Test2', 0, 1); // adds 'Test2' to row 1 column 2
  TListDisplay.AddElement('Test1', 1, 1); // adds 'Test1' to row 2 column 2  
```
---
### `Delete(Id, Column: Integer):` Delete element of (`Id`) in chosen list (`Colum`n)
Deletes the element at position `Id` from the chosen list (`Column`).

> * `Id` (type: Integer) - the position of the element to be deleted.
> * `Column` (type: Integer) - the column number from which the element should be deleted.

**Example:**
```Delphi
  TListDisplay.Delete(1, 1); // Deleted element 'Test1' from previous example
```
---
### `Select(Id: Integer):`
Changes the background color of shapes in the list at position `Id` for both columns. Scrolls down if the selection is out of the range of `FMax`.

> * `Id` (type: Integer) - the position for which the background color should be changed.

  **Example:**
```Delphi
  TListDisplay.Select(0); // Elements 'Test2' and 'Test1' are selected
```
---
### `Clear(Column: Integer):`
Clears the all text in the specified column (`Column`).

> * `Column` (type: Integer) - the column number to be cleared.

  **Example:**
```Delphi
  TListDisplay.Clear(1); // Column with 'Test2' has been cleared 
```
---
## 5. `Items(Id: Integer): string;`
A function that returns the text of the element at position `Id` from `FLabels2`. For a now only For Flabels2, maybe later i will finish it

> * `Id` (type: Integer) - the position of the element to retrieve.

  **Example:**
```Delphi
  var i := String;
  i := TListDisplay.Items(0); // i = 'Test3' 
```
---
## 6. `Exchange(i, j, Column: Integer):`
Exchanges the element at position `i` with the element at position `j` in the chosen list (`Column`).

> * `i` (type: Integer) - the position of the first element to be exchanged.
> * `j` (type: Integer) - the position of the second element to be exchanged.
> * `Column` (type: Integer) - the column number in which the exchange should occur.

  **Example:**
| Before  | After |
| ----- | ------ |
| Test3 | Test4  |
| Test4 | Test3  |
| ...   | ...    |

```Delphi
  TListDisplay.AddElement('Test4', 1, 0);
  TListDisplay.Exchange(0, 1, 0); // 'Test4' top of column 2, 'Test3' is bellow 
```
---
## 7. `Reverse(Column: Integer):`
Reverses all selected column (`Column`).

> * `Column` (type: Integer) - the column number whose list should be reversed.

  **Example:**
```Delphi
  TListDisplay.Reverse(1); // Column 2 reversed and i looks like before
```
---
## 8. `AssignStringsToColumn(ElementStrings: TStrings; Column: Integer):`
Replaces all elements in the selected column (`Column`) with the elements provided in the `ElementStrings` object.

> * `ElementStrings` (type: TStrings) - the list of texts to be assigned to the selected column.
> * `Column` (type: Integer) - the column number whose elements should be replaced.

  **Example:**
```Delphi
  TListDisplay.AssignStringsToColumn(ImportFile, 1); // Column 2 has been replaced by a list: ImportFIle
```
---
**Know Error:**
> If you place a group box below the list, the list text will be created below the group box area and the user will not see the text.

  



