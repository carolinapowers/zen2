import { assert } from 'chai';
import subject from './graphqlErrorsForReduxForm';

describe('utils/graphqlErrorsForReduxForm', () => {
    it('unmarshal nested errors', () => {
        assert.deepEqual(subject([
            {
                field: "project.name",
                message: "This is sparta!"
            }
        ], { stripPrefix: "project." }), {
            "name": ["This is sparta!"]
        });
    });
});
