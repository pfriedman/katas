## Description 

### group_by_owners

Implement a `group_by_owners` function that:

* Accepts a hash containing the file owner name for each file name.
* Returns a hash containing an array of file names for each owner name, in any order.

For example, for hash 

```
{'Input.txt' => 'Randy', 'Code.py' => 'Stan', 'Output.txt' => 'Randy'} 
```

the `group_by_owners` function should return 

```  
{'Randy' => ['Input.txt', 'Output.txt'], 'Stan' => ['Code.py']}.
```

### filter

Implement the `filter` method. It should accept a list of students and a variable number of filters. The filters will be passed in as lambdas, each of which will take one student record and return a boolean value.
filter should return a list of student records that have passed through all the filters.
If no filters are provided, the list of student records should be returned as is. If no students pass through all the provided
filters (or if no students are provided), return an empty array. For example, consider the following code:
```
students = [
{ name: 'Thomas Edison', gpa: 3.45 },
{ name: 'Grace Hopper', gpa: 3.99 },
{ name: 'Leonardo DaVinci', gpa: 2.78 }
]

honor_roll = ->(record) { record[:gpa] > 3.0 } 
filter(students, honor_roll)
```

should return:

```
[{:name=>"Thomas Edison", :gpa=>3.45},{:name=>"Grace Hopper", :gpa=>3.99}]
```
