import os
from frictionless import *
from dotenv import load_dotenv

load_dotenv()

package = describe(source="output/municipios.csv", type="package")
package.to_sql(os.getenv('DB_CONNECTION'))

package = describe(source="output/ceps.csv", type="package")
package.to_sql(os.getenv('DB_CONNECTION'))
