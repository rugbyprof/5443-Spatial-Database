### Postgresql

```SQL
sudo -u postgres createuser -s $USER

createdb griffin

psql -d griffin

psql -U postgres -d <dbname>
griffin=# ALTER USER griffin WITH PASSWORD 'rugger31';

griffin=# ALTER USER griffin VALID UNTIL 'infinity';
```