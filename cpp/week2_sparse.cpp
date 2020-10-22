#include<iostream>
#include<vector>

using namespace std;

vector<vector<int>> convert(vector<int> u, vector<int> v) {
  vector<vector<int>> rtn = {};
  for(int i = 0; i < u.size(); i++) {
    while (rtn.size() <= u[i]) rtn.push_back({});
    rtn[u[i]].push_back(v[i]);
  }
  return rtn;
}


int main()
{
    vector<int> u{ 0, 1, 2, 3, 0, 1, 2, 3, 2, 1 };
    vector<int> v{ 1, 3, 0, 1, 2, 1, 2, 2, 1, 2 };
    vector<vector<int>> row = convert(u, v);
    // check solution
    vector<int> row0 { 1, 2 };
    vector<int> row1 { 3, 1, 2 };
    vector<int> row2 { 0, 2, 1 };
    vector<int> row3 { 1, 2 };
    vector< vector<int> > soln { row0, row1, row2, row3 };
    bool all_good = true;
    if(row.size()!=soln.size())
    {
        all_good = false;
    } else
    {
        for(int i=0; i<4; i++)
        {
            if(row[i].size()!=soln[i].size())
            {
                all_good = false;
                break;
            }
            for(int j=0; j<row[i].size(); j++)
            {
                if(row[i][j]!=soln[i][j])
                {
                    all_good = false;
                    break;
                }
            }
            if(!all_good) break;
        }
    }
    if(all_good)
    {
        cout << "Working solution!" << endl;
    } else
    {
        cout << "Not right." << endl;
    }
	return 0;
}
